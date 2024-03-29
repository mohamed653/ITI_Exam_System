﻿
using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.IRepository
{
    public interface IStudentRepository
    {
        public List<Student> GetAllStudents();
        public User GetStudentById(int id);
        //public Status DeleteStudentById(int id);
        //public Status CreateStudent(Student student);
        //public Status UpdateStudent(int id, Student student);
        int GetStudentByIdByName(string? userName);

        public List<Student> GetStudentsByDeptId(int deptId);
    }
}
