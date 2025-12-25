const express = require('express');
const router = express.Router();
const {all, add} = require('../controllers/employees')
const {auth,} = require('../middleware/auth');

//* /api/employees
router.get('/', auth, all);
//* /api/employees/:id
router.get('/:id', auth, () => console.timeLog('get single emplpyees'));
//* /api/employees/add
router.post('/add', auth, add);
//* /api/employees/remove
router.post('/remove/id', auth, () => console.timeLog('remove emplpyee'));
//* /api/employees/edit
router.post('/edit/:id', auth, () => console.timeLog('remove emplpyee'));

module.exports = router;