
/**
 * Home
 * @param {*} req 
 * @param {*} res 
 */
const home_index = (req, res) => {
    res.render('index',  { 'title': 'Home', 'page_name': 'home' });
}

module.exports = {
    home_index
}
