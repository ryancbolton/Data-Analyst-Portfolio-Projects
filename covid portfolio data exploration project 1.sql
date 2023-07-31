-- CREATE TABLE CovidDeaths(
-- iso_code VARCHAR(100),
-- continent VARCHAR(100),
-- location VARCHAR(100),
-- date VARCHAR(100),
-- population NUMERIC,
-- total_cases NUMERIC,
-- new_cases	NUMERIC,
-- new_cases_smoothed	NUMERIC,
-- total_deaths	NUMERIC,
-- new_deaths	NUMERIC,
-- new_deaths_smoothed	NUMERIC,
-- total_cases_per_million	NUMERIC,
-- new_cases_per_million	NUMERIC,
-- new_cases_smoothed_per_million	NUMERIC,
-- total_deaths_per_million	NUMERIC,
-- new_deaths_per_million	NUMERIC,
-- new_deaths_smoothed_per_million	NUMERIC,
-- reproduction_rate	NUMERIC,
-- icu_patients	NUMERIC,
-- icu_patients_per_million	NUMERIC,
-- hosp_patients	NUMERIC,
-- hosp_patients_per_million	NUMERIC,
-- weekly_icu_admissions	NUMERIC,
-- weekly_icu_admissions_per_million	NUMERIC,
-- weekly_hosp_admissions	NUMERIC,
-- weekly_hosp_admissions_per_million	NUMERIC
-- )

-- SELECT * FROM CovidDeaths

/* Select the Data that we are going to be using */
-- SELECT location, date, total_cases, new_cases, total_deaths, population 
-- FROM CovidDeaths

/* Looking at Total Cases vs Total Deaths */
/* Show likelihood of dying if you contract Covid in your country */
-- SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
-- FROM CovidDeaths
-- WHERE location like '%States%'

/* Looking at Total Cases vs Population */
/* Shows what percentage of the population contracted Covid */
-- SELECT location, date, population, total_cases, (total_cases/population)*100 as InfectedPercentage
-- FROM CovidDeaths
-- WHERE location like '%States%'

/* Looking at Countries with Highest Infection Rate compared to Population */
-- SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
-- FROM CovidDeaths
-- -- WHERE location like '%States%'
-- GROUP BY location, population
-- ORDER BY PercentPopulationInfected desc

/* Showing Countries/Continents with Highest Death Count per Population */
-- SELECT location, MAX(total_deaths) AS TotalDeathCount
-- FROM CovidDeaths
-- -- WHERE location like '%States%'
-- WHERE continent is null
-- GROUP BY location
-- ORDER BY TotalDeathCount desc

-- SELECT continent, MAX(total_deaths) AS TotalDeathCount
-- FROM CovidDeaths
-- -- WHERE location like '%States%'
-- WHERE continent is not null
-- GROUP BY continent
-- ORDER BY TotalDeathCount desc

/* GLOBAL NUMBERS */
-- SELECT date, SUM(new_cases), SUM(new_deaths), SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
-- FROM CovidDeaths
-- WHERE continent is not null
-- GROUP BY date
-- ORDER BY 1,2


/* USE CTE */
-- With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) 
-- as
-- (
-- /* Looking at Total Population vs Vaccinations */
-- SELECT dea.continent, dea.location, Cast(dea.date as date), dea.population, vac.new_vaccinations 
-- , SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
-- --, (RollingPeopleVaccinated/population)*100
-- FROM CovidDeaths dea
-- Join CovidVaccinations vac
-- On dea.location = vac.location
-- AND dea.date = vac.date
-- WHERE dea.continent is not null
-- --ORDER BY 2,3
-- )
-- SELECT *, (RollingPeopleVaccinated/Population)*100 as PercentVaccinated
-- FROM PopvsVac

/* Creating View to store data for later visualizations */
Create View PercentPopulationVaccinated as
SELECT dea.continent, dea.location, Cast(dea.date as date), dea.population, vac.new_vaccinations 
, SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM CovidDeaths dea
Join CovidVaccinations vac
On dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3

-- SELECT * FROM PercentPopulationVaccinated

-- CREATE TABLE CovidVaccinations(
-- iso_code VARCHAR(100),
-- continent VARCHAR(100),
-- location VARCHAR(100),
-- date VARCHAR(100),
-- total_tests VARCHAR(100),
-- new_tests VARCHAR(100),
-- total_tests_per_thousand	VARCHAR(100),
-- new_tests_per_thousand	VARCHAR(100),
-- new_tests_smoothed	VARCHAR(100),
-- new_tests_smoothed_per_thousand	VARCHAR(100),
-- positive_rate	VARCHAR(100),
-- tests_per_case	VARCHAR(100),
-- tests_units	VARCHAR(100),
-- total_vaccinations	VARCHAR(100),
-- people_vaccinated	VARCHAR(100),
-- people_fully_vaccinated	VARCHAR(100),
-- total_boosters	VARCHAR(100),
-- new_vaccinations	VARCHAR(100),
-- new_vaccinations_smoothed	VARCHAR(100),
-- total_vaccinations_per_hundred	VARCHAR(100),
-- people_vaccinated_per_hundred	VARCHAR(100),
-- people_fully_vaccinated_per_hundred	VARCHAR(100),
-- total_boosters_per_hundred	VARCHAR(100),
-- new_vaccinations_smoothed_per_million	VARCHAR(100),
-- new_people_vaccinated_smoothed	VARCHAR(100),
-- new_people_vaccinated_smoothed_per_hundred	VARCHAR(100),
-- stringency_index	VARCHAR(100),
-- population_density	VARCHAR(100),
-- median_age	VARCHAR(100),
-- aged_65_older	VARCHAR(100),
-- aged_70_older	VARCHAR(100),
-- gdp_per_capita	VARCHAR(100),
-- extreme_poverty	VARCHAR(100),
-- cardiovasc_death_rate	VARCHAR(100),
-- diabetes_prevalence	VARCHAR(100),
-- female_smokers	VARCHAR(100),
-- male_smokers	VARCHAR(100),
-- handwashing_facilities	VARCHAR(100),
-- hospital_beds_per_thousand	VARCHAR(100),
-- life_expectancy	VARCHAR(100),
-- human_development_index	VARCHAR(100),
-- excess_mortality_cumulative_absolute  VARCHAR(100),
-- excess_mortality_cumulative	VARCHAR(100),
-- excess_mortality	VARCHAR(100),
-- excess_mortality_cumulative_per_million	VARCHAR(100)
-- )

-- SELECT * FROM CovidVaccinations
