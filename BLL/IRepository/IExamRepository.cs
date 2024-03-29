﻿using BLL.ViewModels;
using DAL.Data;
using DAL.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.IRepository
{
    public interface IExamRepository
    {
        Exam GetExamById(int ExamId);
        List<Exam> GetAllExamByStudentId(int StudentId);
        Exam GetCurrentExamByStudentId(int StudentId);
        int GenerateExamByCrsId(int CrsId, DateTime date, TimeSpan duration);
        List<Question> GetQuestionsByExamId(int ExamId);
        List<Choice> GetChoicesByQuestionId(int QuestId);
        Status SubmitStudentExam(StudentExamViewModel studentExamViewModel);
        Tuple<int, int> CalculateTotalGrade(StudentExamViewModel studentExamViewModel);
        bool IsStudentExamSubmitted(int StudentId, int ExamId);
        public bool IsExamTimeUp(int ExamId);
        Exam GetExamByCourseId(int CourseId);
        int? GetStudentAnswer(int stdId, int qId, int exId);
        public void AssignExamToStudents(int examId, List<int> studentsIds);
    }
}
