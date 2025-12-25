const {prisma} = require('../prisma/prisma-client');

/**
 * @route GET /api/employees
 * @desc Получение всех сотрудников
 * @access Private
 */
const all = async (req,res) => {
    try{
        const employees = await prisma.employee.findmany();

        res.status(200).json(employees)
    } catch(error){
        res.status(500).json({message: 'не удалось получить список сотрудников'})
    }
}


/**
 * @route POST /api/employees/add
 * @desc Добавление сотрудника
 * @access Private
 */
const add = async (req, res) =>{
    try{
        const data = req.body;

        if(!data.firtsName || !data.lastName || !data.adress || !data.age){
            return res.status(400).json({message: 'Все поля обязательные'})
        }

        const employee = await prisma.user.update({
            where:{
                id: req.user.id
            },
            data:{
                createdEmployee:{
                    create: data
                }
            }
        });
        return res.status(201).json(employee)

    }catch{
        res.status(500).json({message: 'Что-то пошло не так'});
    }
}

module.exports = {
  all,
  add,
};