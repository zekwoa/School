/*this query is used for displaying all student and their information*/
select * from student;

/*this query is used for displaying the name of students and their birth date*/
select s.s_name , s.s_Bdate
from student s;

/*this query is used for displaying the name who lives in mohandeseen*/
select e.e_name , e.e_address from employee e where e.e_address like '%mohandeseen%';

/*this query is used for displaying each subject and it's total marks*/
select s.sub_name , s.score 
from subject s;

/*this query is used for displaying the summer activity that's avilable for the syudents and it's start date*/
select s.SA_name , s.SA_start
from sa s;

/*this query is used for displaying the total score of the student whose ssn is 445566771*/
select s.s_ssn , st.subject_name , st.oral , st.midterm , st.final , st.total 
from student s , study st where s.s_ssn = '445566771' ;

/*this query is used for displaying the salary of the employee whose ssn is 168603208*/
select e.e_ssn , e.e_salary
from employee e where e.e_ssn='168603208';

/*this query is used for displaying the employees and their dependents and the relationship*/
select e.e_name as employee_name , d.d_name as dependent , d.d_relatioship as relationship
from employee e , dependent d;

/*this query is used for displaying student's score in each subject*/
select s.s_name as student_name , sc.total as subject_score 
from student s, study sc where s.s_ssn=sc.student_ssn;

/*this query is used for displaying the time table for 1/3 class*/ 
select h.class as class , h.sub_name as 'subject' , h.day as 'day' , h.from , h.to
from has h where h.class='1/3' ;

/*this query is used for displaying the score of arabic midterm exam for all the students in class 2/2*/
select s.s_name as student_name , sc.midterm as midterm_score 
from student s, study sc where s.s_ssn=sc.student_ssn and sc.subject_name='arabic';

/*this query is used for displaying the total score of students who got less than 5 in science oral exam*/
select s.s_name as student_name , sc.total as total_score 
from student s, study sc where s.s_ssn=sc.student_ssn and sc.subject_name='science' and sc.oral < 5 ;

/*this query is used for displaying the sum of salaries of all subject's teachers*/
select t.subject_name , sum(e.e_salary) as sumsalary 
from employee e , teacher t where e.e_ssn=t.employee_ssn group by t.subject_name;

/*this query is used for displaying the average total score of all the subjects*/
select avg(s.total) as avg_total_score , s.subject_name 
from study s group by s.subject_name;

/*this query is used for displaying the each employee name and his/her dependent name*/
select e.e_name , d.d_name
from employee e left outer join dependent d on
e.e_ssn=d.employee_ssn;

/*this query is used for displaying the sum of students in each summer activity sport*/
select count(s.s_name) , a.SA_name as summer_activity
from student s , sa a group by a.SA_name;

/*this query is used for displaying the minimum and the maximum and the average salaries of the employee*/
select min(e.e_salary) , max(e.e_salary) , avg(e.e_salary)
from employee e;

/*this query is used for displaying the employee who get salary between 5000 and 7000 */
select e.e_name , e.e_salary 
from employee e where e.e_salary between 5000 and 7000;

/*this query is used for displaying teacher's name and his subject*/
select e.e_name as teacher_name , t.subject_name
from employee e join teacher t on(e.e_ssn=t.employee_ssn);

/*this query is used for displaying the name of students who got total score more than the average score in english*/
select s.s_name as student_name , st.total as total_score 
from student s , study st where st.total > (select avg(st.total) from study st where st.subject_name = 'english');





