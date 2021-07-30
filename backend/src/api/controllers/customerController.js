const helpers = require('../../helper/util.js');
const Customer = require('../../models/customer.js');

const {
  validateRegisterDetails,
  validateLoginDetails,
  hashPassword,
  createToken,
  errorResponse,
  comparePasswords
} = helpers;


class CustomerController {

  //register
  static async register(req, res) {

    try {
      const { name, email, password, address_1 } = req.body;

      const  {error} = validateRegisterDetails(req.body);
      if (error) {
        const errorField = error.details[0].context.key;
        const errorMessage = error.details[0].message;
        return errorResponse(res, 400, 'USR_01', errorMessage, errorField);
      }

      
      const existingCustomer = await Customer.findByEmail(email);
      if (existingCustomer) return errorResponse(res, 409, 'USR_04', 'The email already exists.', 'email');
      
      const hashedPassword = await hashPassword(password);
      console.log(hashedPassword);
      const customer = await Customer.create({
        name,
        email,
        password: hashedPassword,
        address_1,
      });
      await customer.reload();
      delete customer.dataValues.password;
      const token = createToken(customer);
      return res.status(200).json({
        accessToken: `Bearer ${token}`,
        customer,
        expires_in: '24h'
      });

    } catch (error) {
      res.status(500).json({ error: 'Internal Server Error fuuu' });
    }
  }


  //login
  static async login(req, res) {
    const { email, password } = req.body;
    try {
      const { error } = validateLoginDetails(req.body);
      if (error) {
        const errorField = error.details[0].context.key;
        const errorMessage = error.details[0].message;
        return errorResponse(res, 400, 'USR_01', errorMessage, errorField);
      }

      const existingCustomer = await Customer.scope('withoutPassword').findByEmail(email);
      if (!existingCustomer) return errorResponse(res, 400, 'USR_05', "The email doesn't exist", 'email');

      const match = await comparePasswords(password, existingCustomer.dataValues.password);
      if (match) {
        const customer = existingCustomer.dataValues;
        delete existingCustomer.dataValues.password;
        const token = await createToken(customer);
        res.status(200).json({
          accessToken: `Bearer ${token}`,
          customer,
          expires_in: '24h'
        });
      } else {
        return errorResponse(res, 400, 'USR_01', 'Email or Password is invalid.');
      }
    } catch (error) {
      res.status(500).json({ error: 'Internal Server Error' });
    }
  }


  //return detail about a customer
  static async getCustomer(req, res) {
    try {
      const customer = await Customer.scope('withoutPassword').findOne({
        where: { customer_id: req.user.customer_id }
      });
      if (!customer) {
        return errorResponse(res, 404, 'USR_04', 'Customer does not exist.');
      }
      return res.status(200).json(customer);
    } catch (error) {
      res.status(500).json({ error: 'Internal Server Error' });
    }
  }

}

module.exports = CustomerController