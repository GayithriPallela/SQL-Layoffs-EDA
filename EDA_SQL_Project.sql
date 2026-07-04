--  EDA Project on SQL ---
use world_layoffs;
SELECT * 
FROM layoffstaging2;

SELECT MAX(total_laid_off) , MAX(percentage_laid_off)
FROM layoffstaging2;

SELECT * 
FROM layoffstaging2 
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company,SUM(total_laid_off)
from layoffstaging2
group by company
order by 2 desc;

SELECT MIN(`date`), MAX(`date`)
FROM layoffstaging2;

Select industry,SUM(total_laid_off)
FROM layoffstaging2
GROUP BY industry
order by 2 DESC;

Select YEAR(`date`),SUM(total_laid_off)
FROM layoffstaging2
GROUP BY YEAR(`date`)
order by 1 DESC;

SELECT company , avg(percentage_laid_off) 
 from layoffstaging2
 group by company
 order by 2 desc;
 
 SELECT stage , sum(percentage_laid_off) 
 from layoffstaging2
 group by stage
 order by 2 desc;
 
 SELECT SUBSTRING(`DATE`,1,7) AS `MONTH`,SUM(total_laid_off)
 FROM layoffstaging2
 WHERE SUBSTRING(`DATE`,1,7) IS NOT NULL 
 GROUP BY `MONTH`
 ORDER BY 1;
 
 WITH Rolling_total AS 
 (
  SELECT SUBSTRING(`DATE`,1,7) AS `MONTH`,SUM(total_laid_off) as total_off
 FROM layoffstaging2
 WHERE SUBSTRING(`DATE`,1,7) IS NOT NULL 
 GROUP BY `MONTH`
 ORDER BY 1 ASC
 )
 SELECT `MONTH`,sum(total_off) OVER (ORDER BY `MONTH`) AS ROLLING_TOTAL
 FROM Rolling_Total;
 
 
 SELECT company ,sum(total_laid_off)
 from layoffstaging2
 group by company
 order by 2 desc;
 
 SELECT company ,YEAR( `date`) , sum(total_laid_off)
 from layoffstaging2
 group by company, YEAR(`date`)
 order by 3 desc;
 
 WITH Company_Year(company, years, total_laid_off) AS 
 (
 SELECT company, YEAR(`date`), SUM(total_laid_off)
 FROM layoffstaging2
 group by  company,YEAR(`DATE`)
 ), company_year_rank as 
 (select *, DENSE_RANK() OVER (Partition by  years order by total_laid_off desc) as ranking 
 FROM Company_Year
where years is not null
)
select * from 
 company_year_rank
 where ranking <=5;	