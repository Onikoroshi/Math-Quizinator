Math-Quizinator
===============

A Ruby On Rails application intended to help teachers generate math quizzes, and students to take them.

The Problem:

Creating math tests by hand is tedious, error-prone, and time-consuming. Grading them is similarly frustrating. Although word problems are by necessity human-created, most other math problems and their solutions can easily be done by a computer.

The Solution:

A Ruby On Rails application that maintains a database of math problems, using that database to generate math quizzes and grade them.

Core Features:
- [implemented] Teachers can Create, Retrieve, Update, and Destroy Math Problems from the database.
- [implemented] Each Math Problem has a Question and an Answer.
- [implemented] Teachers can also Create, Retrieve, Update, and Destroy Quizzes using the math problems in the database.
- [implemented] Each Quiz has a set of Math Problems.
- [implemented] Students can take any Quiz in the database.
- [implemented] When a Quiz is submitted, a Score is given, and the wrong answers are highlighted. The Student can then take the Quiz again.

Prioritized Additional Features:
- [implemented] Teachers can use specific criteria to create random Math Problems.
- Authentication for Students and Teachers.
- Persistence for Students and Teachers. Students have a database of completed Quizzes, Teachers have a database of Students and another of Quizzes they have created.
- Add Subject Tags to Math Problems (eg Addition, Subtraction, Fractions, etc).
- Allow Teachers to generate randomized Quizzes.
