import {
  getAllCategories,
  getCategoryDetails,
  getCategoriesByServiceProjectId,
  createCategory,
  updateCategory,
  updateCategoryAssignments,
} from "../models/categories.js";
import { getProjectDetails } from "../models/projects.js";
import { body, validationResult } from "express-validator";

const showCategoriesPage = async (req, res) => {
  const categories = await getAllCategories();
  const title = "Service Project Categories";

  res.render("categories", { title, categories });
};

const categoryValidation = [
  body("name")
    .trim()
    .notEmpty()
    .withMessage("Category name is required")
    .isLength({ min: 3, max: 100 })
    .withMessage("Category name must be between 3 and 100 characters"),
];

const showNewCategoryForm = async (req, res) => {
  const title = "Add New Category";

  res.render("new-category", { title });
};

const processNewCategoryForm = async (req, res) => {
  const results = validationResult(req);
  if (!results.isEmpty()) {
    results.array().forEach((error) => {
      req.flash("error", error.msg);
    });
    return res.redirect("/new-category");
  }

  const { name } = req.body;

  await createCategory(name);

  req.flash("success", "Category added successfully!");
  res.redirect("/categories");
};

const showEditCategoryForm = async (req, res) => {
  const categoryId = req.params.id;
  const categoryDetails = await getCategoryDetails(categoryId);
  const title = "Edit Category";

  res.render("edit-category", { title, categoryDetails });
};

const processEditCategoryForm = async (req, res) => {
  const categoryId = req.params.id;

  const results = validationResult(req);
  if (!results.isEmpty()) {
    results.array().forEach((error) => {
      req.flash("error", error.msg);
    });
    return res.redirect(`/edit-category/${categoryId}`);
  }

  const { name } = req.body;

  await updateCategory(categoryId, name);

  req.flash("success", "Category updated successfully!");
  res.redirect("/categories");
};

const showAssignCategoriesForm = async (req, res) => {
  const projectId = req.params.projectId;
  const projectDetails = await getProjectDetails(projectId);
  const categories = await getAllCategories();
  const assignedCategories = await getCategoriesByServiceProjectId(projectId);
  const title = "Assign Categories to Project";

  res.render("assign-categories", {
    title,
    projectDetails,
    categories,
    assignedCategories,
  });
};

const processAssignCategoriesForm = async (req, res) => {
  const projectId = req.params.projectId;

  // One checked box arrives as a string, none as undefined, several as an array
  const categoryIds = [].concat(req.body.categoryIds || []);

  await updateCategoryAssignments(projectId, categoryIds);

  req.flash("success", "Categories updated successfully!");
  res.redirect(`/project/${projectId}`);
};

export {
  showCategoriesPage,
  showNewCategoryForm,
  processNewCategoryForm,
  showEditCategoryForm,
  processEditCategoryForm,
  showAssignCategoriesForm,
  processAssignCategoriesForm,
  categoryValidation,
};