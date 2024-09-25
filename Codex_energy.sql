Create database codex_coffee;
use codex_coffee;

select gender, count(*) as gender_count
 from dim_repondents
 group by gender;
 
SELECT dr.gender, fr.consume_frequency, COUNT(fr.consume_frequency) AS frequency_count
FROM dim_repondents dr
JOIN fact_survey_responses fr
ON dr.respondent_id = fr.respondent_id
GROUP BY dr.gender, fr.consume_frequency
ORDER BY dr.gender, frequency_count DESC;

select dr.age,fr.consume_frequency,count(fr.consume_frequency) as age_interest
from dim_repondents dr
join fact_survey_responses fr
on dr.respondent_id = fr.respondent_id
group by dr.age,fr.consume_frequency
order by dr.age,age_interest desc; 

-- Popular marketing channels among youth (15-30)
SELECT fr.marketing_channels, COUNT(fr.marketing_channels) AS channel_count
FROM dim_repondents dr
JOIN fact_survey_responses fr
ON dr.respondent_id = fr.respondent_id
WHERE dr.age = 15-18 or 19-30
GROUP BY fr.marketing_channels
ORDER BY channel_count DESC;

-- expected ingredients in the energy drink by respondents
select fr.ingredients_expected, count(fr.respondent_id) as preffered_ingrident
from fact_survey_responses fr
group by fr.ingredients_expected;

-- preffered packaging
select fr.packaging_preference, count(fr.respondent_id) as preferences
from fact_survey_responses fr
group by fr.packaging_preference
order by preferences desc;

-- Finding current market leaders based on the survey
select fr.current_brands, count(fr.respondent_id) as Brand_specific_consumers
from fact_survey_responses fr
group by fr.current_brands
order by Brand_specific_consumers desc limit 1;

-- reasons for prefering other brands
SELECT fr.Reasons_for_choosing_brands, COUNT(fr.respondent_id) AS reason_count
FROM fact_survey_responses fr
WHERE fr.current_brands <> 'Codex'
GROUP BY fr.Reasons_for_choosing_brands
ORDER BY reason_count DESC;

-- number of customers marketing channels helped achieve for codex
select fr.marketing_channels, count(respondent_id) as Codex_market_chain
from fact_survey_responses fr
where current_brands = 'codex'
group by fr.marketing_channels
order by codex_market_chain desc;


select fr.marketing_channels, count(respondent_id) as Codex_market_chain
from fact_survey_responses fr
where current_brands = 'cola-coka'
group by fr.marketing_channels
order by codex_market_chain desc;

SELECT fr.marketing_channels, 
       COUNT(fr.respondent_id) AS count, 
       'Codex' AS brand
FROM fact_survey_responses fr
WHERE fr.current_brands = 'codex'
GROUP BY fr.marketing_channels

UNION ALL

SELECT fr.marketing_channels, 
       COUNT(fr.respondent_id) AS count, 
       'Cola-Coka' AS brand
FROM fact_survey_responses fr
WHERE fr.current_brands = 'cola-coka'
GROUP BY fr.marketing_channels

ORDER BY marketing_channels, count DESC;

SELECT
    SUM(CASE WHEN fr.current_brands = 'codex' AND fr.brand_perception LIKE '%positive%' THEN 1 ELSE 0 END) AS positive_brand_perception,
    SUM(CASE WHEN fr.current_brands = 'codex' AND fr.brand_perception LIKE '%negative%' THEN 1 ELSE 0 END) AS negative_brand_perception,
    SUM(CASE WHEN fr.current_brands = 'codex' AND fr.general_perception LIKE '%Healthy%' THEN 1 ELSE 0 END) AS positive_general_perception,
    SUM(CASE WHEN fr.current_brands = 'codex' AND fr.general_perception LIKE '%dangerous%' THEN 1 ELSE 0 END) AS negative_general_perception,
    SUM(CASE WHEN fr.current_brands = 'codex' AND fr.taste_experience LIKE '%5%' THEN 1 ELSE 0 END) AS positive_taste_experience,
    SUM(CASE WHEN fr.current_brands = 'codex' AND fr.taste_experience LIKE '%1%' THEN 1 ELSE 0 END) AS negative_taste_experience,
    COUNT(*) AS total_responses
FROM fact_survey_responses fr
WHERE 
fr.current_brands = 'codex';


select fr.purchase_location, count(fr.respondent_id) as Location_preference
from fact_survey_responses fr
where fr.current_brands = 'codex'
group by purchase_location