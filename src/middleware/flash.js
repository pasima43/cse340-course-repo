const emptyFlash = () => ({
  success: [],
  error: [],
  warning: [],
  info: [],
});

const flashMiddleware = (req, res, next) => {
  req.flash = function (type, message) {
    if (!req.session.flash) {
      req.session.flash = emptyFlash();
    }

    if (type && message) {
      if (!req.session.flash[type]) {
        req.session.flash[type] = [];
      }
      req.session.flash[type].push(message);
      return;
    }

    if (type && !message) {
      const messages = req.session.flash[type] || [];
      req.session.flash[type] = [];
      return messages;
    }

    const allMessages = req.session.flash || emptyFlash();
    req.session.flash = emptyFlash();
    return allMessages;
  };

  next();
};

const flashLocals = (req, res, next) => {
  res.locals.flash = req.flash;
  next();
};

const flash = (req, res, next) => {
  flashMiddleware(req, res, () => {
    flashLocals(req, res, next);
  });
};

export default flash;