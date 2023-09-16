'use strict';

// Not currently plugged in, because Yoli's SMTP auth settings need to be adjusted, either globally or for the outgoing email address, for this to work.
const nodemailer = require('nodemailer');
const dotenv = require('dotenv');
dotenv.config();

module.exports = async function sendEmail(recipients, subject, text, html) {
  // Create reusable transporter object using the default SMTP transport.
  let transporter = nodemailer.createTransport({
    host: process.env.NODEMAILER_ADMIN_HOST,
    port: process.env.NODEMAILER_ADMIN_PORT,
    secureConnection: false, // true for 465, false for other ports
    auth: {
      user: process.env.NODEMAILER_ADMIN_USERNAME,
      pass: process.env.NODEMAILER_ADMIN_PWD,
    },
    tls: { ciphers:'SSLv3' }
  });

  // Send email with a defined transport object.
  let info = await transporter.sendMail({
    from: process.env.NODEMAILER_ADMIN_EMAIL, // Sender;s address.
    to: recipients, // list of comma-separated recipients.
    subject, // Subject line
    text, // plain text body
    html, // html body
  });

  return info.messageId; // Message sent: <b658f8ca-6296-ccf4-8306-87d57a0b4321@example.com>
}
