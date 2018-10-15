# Music Festival Demo App

Created with Visual Studio 2017, this ASP.NET MVC Application is a demo project based on requirements of the Federated Music Clubs of America. Its purpose is to allow teachers to enter student’s enrollment, allow coordinators to schedule auditions, tabulate ratings awarded by judges, and track accumulated points from year to year for special recognition of achievement. It allows teachers to select the appropriate category for each student, according to the festival rules, and choose from required music selections for that category.

Prospective employers can load the project and peruse the source code. Some quick background:

* Demonstrates my depth of analysis and productivity, starting from a set of complex requirements, and in 6 weeks completing:
** Database schema - normalized tables, with all data access through stored procedures, using Dapper.
** User authentication with three role categories, different layout for each.
** Robust models and view models.
** Controllers that handle errors gracefully.
** Extensive use of Ajax, jQuery validation.
** C# code which demonstrates a thorough understanding of the language elements.

* Project begun Sept 3, 2018 as a Web Forms ASP.NET project. Two weeks later, converted and continued as an MVC project.
* Core functionality, minus reports, finished Oct 15, 2018.
* See the Project Blueprint in the Solution Items folder for an overview.

### Installing

* restore backup of SQL Server database to your SQL server
* load the Visual Studio solution, FestivalMVC.sln.
* edit web.config connection string to point to your server
* Right-click on the database project, FestivalDatabase, and do a schema compare.
* Update the database schema from the project (select your server as the target first.)
* Run the project. Sample user names: accc1000 (top level Admin role), hcard1000 (Chair role), gbroo1000 (Teacher role). All passwords are 'Festival@2020'.


## Built With

* Visual Studio 2017 Community Edition
* SQL Server Express 14.0
* Bootstrap 3.0.3, CSS
* jQuery 3.3.1, Javascript (ECMAscript 5 browsers)
* Dapper

## Authors

* **Greg Corron** [LinkedIn](https://www.linkedin.com/in/greg-corron-b88455168/)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


