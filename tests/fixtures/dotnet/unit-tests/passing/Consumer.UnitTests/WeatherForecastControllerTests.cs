namespace Consumer.UnitTests;

using Consumer.WebApi;
using Consumer.WebApi.Controllers;

public class WeatherForecastControllerTests
{
    [Fact]
    public void ShouldPass()
    {
        IEnumerable<WeatherForecast> weatherForecasts = new WeatherForecastController().Get();

        Assert.True(weatherForecasts.Count() > 0);
    }
}
