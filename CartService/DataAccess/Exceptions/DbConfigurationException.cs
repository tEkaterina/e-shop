namespace CartService.DataAccess.Exceptions
{
    public class DbConfigurationException : Exception
    {
        public DbConfigurationException() : base("Unable to startup the database: invalid configuration provided.")
        {

        }
    }
}
