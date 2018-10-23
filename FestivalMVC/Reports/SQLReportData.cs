using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;
using System.Web.UI.WebControls;
using System.Data.Common;

namespace FestivalMVC.Reports
{
    public static class SQLReportData
    {

        public static void PrepareReport(ReportViewer reportViewer, string reportName, string parms)
        {
            reportViewer.ProcessingMode = ProcessingMode.Local;
            LocalReport localReport = reportViewer.LocalReport;
            localReport.ReportPath = HttpRuntime.AppDomainAppPath + "Reports\\" + reportName + ".rdlc";
            localReport.DataSources.Clear();

            var dataset = GetReportData("Report" + reportName + (parms.Length > 0 ? " " + parms : ""));
            int i = 0;
            foreach (var tb in dataset.Tables)
            {
                var dataSource = new ReportDataSource($"DataSet{i + 1}", dataset.Tables[i]);
                localReport.DataSources.Add(dataSource);
                i++;
            }
        }

        private static DataSet GetReportData(string storedProc)
        {
            DataSet result = new DataSet();
            SqlConnection connection = GetDBConnection();
            using (DbCommand command = connection.CreateCommand())
            {
                command.CommandText = storedProc;

                connection.Open();
                using (DbDataReader reader = command.ExecuteReader())
                {
                    do
                    {
                        var tb = new DataTable();
                        tb.Load(reader);
                        result.Tables.Add(tb);
                    } while (!reader.IsClosed);
                }
                connection.Close();
            }
            return result;
        }

        public static SqlConnection GetDBConnection()
        {
            return new System.Data.SqlClient.SqlConnection(CnnVal("FestivalConnection"));
        }

        public static string CnnVal(string name)
        {
            try
            {
                return ConfigurationManager.ConnectionStrings[name].ConnectionString;
            }
            catch
            {
                throw new ArgumentException($"Database connection info for {name} not found!");
            }
        }
    }
}