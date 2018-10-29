using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FestivalMVC
{
    using System;
    using System.Configuration;

    public class UsingRsaProtectedConfigurationProvider
    {

        // Protect the connectionStrings section.
        public static string ProtectConfiguration()
        {

            // Get the application configuration file.

            //workout app.config location
            string dllLocation = AppDomain.CurrentDomain.BaseDirectory + "Web.release.config";
            if (dllLocation == null)
                throw new Exception("Could not find config file, add .config in DLL location");

            System.Configuration.Configuration config =
                    ConfigurationManager.OpenExeConfiguration(dllLocation);

            // Define the Rsa provider name.
            string provider =
                "RsaProtectedConfigurationProvider";

            // Get the section to protect.
            ConfigurationSection connStrings =
                config.ConnectionStrings;

            if (connStrings != null)
            {
                if (!connStrings.SectionInformation.IsProtected)
                {
                    if (!connStrings.ElementInformation.IsLocked)
                    {
                        // Protect the section.
                        connStrings.SectionInformation.ProtectSection(provider);

                        connStrings.SectionInformation.ForceSave = true;
                        config.Save(ConfigurationSaveMode.Full);

                        return $"Section {connStrings.SectionInformation.Name} is now protected by {connStrings.SectionInformation.ProtectionProvider.Name}";
                    }
                    else
                        return $"Can't protect, section {connStrings.SectionInformation.Name} is locked";
                }
                else
                    return $"Section {connStrings.SectionInformation.Name} is already protected by {connStrings.SectionInformation.ProtectionProvider.Name}";
            }
            else
                return $"Can't get the section {connStrings.SectionInformation.Name}";
        }
    }
}