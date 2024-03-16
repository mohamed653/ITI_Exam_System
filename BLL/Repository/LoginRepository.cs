using BLL.IRepository;
using BLL.ViewModels;
using DAL.Data;
using DAL.Models;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Nodes;
using System.Threading.Tasks;

namespace BLL.Repository
{
    public class LoginRepository : iLoginRepositry
    {

        private readonly ITIContext context;

        public LoginRepository(ITIContext _context)
        {
            context = _context;
        }

        public User? check(LoginVM login)
        {

            var name = login.usename;
            var password = login.password;
            var users = context.Users;
            var user = context.Users.FirstOrDefault(u => u.Username == name && u.Password == password);
            var role = user.Role;
            if (user != null)
            {
                return user;
            }
            return null;

        }
    }
}
