
/**
 * Home
 * @param {*} req 
 * @param {*} res 
 */
const home_index = (req, res) => {
    user = req.user
    res.render('index',  { 'title': 'Home', 'page_name': 'home','user':user });
}

module.exports = {
    home_index
}
