using BLL.IRepository;
using BLL.Repository;
using BLL.ViewModels;
using Microsoft.AspNetCore.Mvc;

namespace ExamSystemPL.Controllers
{
    public class LoginController : Controller
    {
        private readonly iLoginRepositry loginRepo;
        public LoginController(iLoginRepositry _loginrepo)
        {
            loginRepo = _loginrepo;
        }
        [HttpGet]
        public IActionResult login()
        {
            return View();
        }
        [HttpPost]
        public IActionResult login(LoginVM v1)
        {
           var user =loginRepo.check(v1 as LoginVM);
            if (user == null)
            {
                return View(v1);
            }
           if (user.Role== "student")
            {
                return RedirectToAction("Index", "Student");
            }else if(user.Role== "instructor")
            {
                return RedirectToAction("Index", "instructor");
            }
            else
            {
                return RedirectToAction("index", "admin");
            }

        }


    }
}
 