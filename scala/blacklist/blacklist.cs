/*
Geoff Ford

I decided to see what C# would look like in a functional aspect.

With heavy doses of {{IEnumerable.ToList<>.AsReadOnly()}} I can prevent the adding and removing of members to lists, but C# does not have the {{final}} keyword to guarantee no side effects on passed in params.
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Collections;

namespace Blacklist
{
    class Program
    {
        static void Main(string[] args)
        {
            // simplistic arg processing
            if (args.Count() == 3)
            {
                var customerFile = args[0];
                var blacklistFile = args[1];
                var outFile = args[2];

                var customers = GetCustomers(customerFile);
                var blacklist = GetBlacklist(blacklistFile);
                var cleaned = StripBlacklisted(customers.Skip(1), blacklist.Skip(1));
                WriteCSV(customers.First().ToString(), cleaned, outFile);
            }
            else
            {
                System.Console.WriteLine("I need more args");
            }

        }

        private static IEnumerable<Customer> StripBlacklisted(IEnumerable<Customer> customers, IEnumerable<string> blacklist)
        {
            return customers.Where(customer => !blacklist.Contains(customer.PostCode)).ToList<Customer>().AsReadOnly();
        }

        private static IEnumerable<string> GetBlacklist(string blacklistFile)
        {
            return ReadCSV(blacklistFile);
        }

        private static IEnumerable<Customer> GetCustomers(string customerFile)
        {
            return ReadCSV(customerFile).Select(l => BuildCustomer(l)).ToList<Customer>().AsReadOnly();
        }

        private static Customer BuildCustomer(string line)
        {
            var parts = line.Split(',');
            return new Customer
            {
                GivenName = parts[0],
                Surname = parts[1],
                StreetAddress = parts[2],
                City = parts[3],
                State = parts[4],
                PostCode = parts[5],
                EmailAddress = parts[6],
                TelephoneNumber = parts[7],
                Birthday = parts[8],
                Gender = parts[9]
            };
        }

        private static IEnumerable<string> ReadCSV(string customerFile)
        {
            return new List<string>(File.ReadAllLines(customerFile)).AsReadOnly();
        }

        private static void WriteCSV(string headers, IEnumerable<Customer> cleaned, string outFile)
        {
            File.WriteAllText(outFile, headers);
            File.AppendAllLines(outFile, cleaned.Select(c => c.ToString()));
        }
    }
}
