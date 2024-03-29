﻿using BLL.ViewModels;
using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace BLL.IRepository
{
    public interface IAccountRepository
    {

        User GetUserAuth(UserLoginModelView userLogin);
        ClaimsPrincipal AddUserAuthentication(User userLogin);
        void AddUser(UserRegisterModelView userRegister);
        User? GetUserByName(string userName);
        List<Department> GetDepartments();
    }
}
