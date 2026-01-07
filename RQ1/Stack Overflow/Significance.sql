WITH CleanTags AS (
    SELECT 
        Id, 
        TRIM(
            REPLACE(
                REPLACE(tag.value, '>', ''), 
                '<', 
                ''
            )
        ) AS tag -- Clean extra characters
    FROM 
        Posts CROSS APPLY STRING_SPLIT(
            REPLACE(
                REPLACE(Tags, '><', ','), 
                '<', 
                ''
            ), 
            ','
        ) AS tag 
    WHERE 
        Id IN ()
),
TagCooccurrence AS (
    SELECT 
        tag, 
        COUNT(DISTINCT Id) AS cooccurrence_count
    FROM 
        CleanTags
    WHERE 
        tag != 'abc'
    GROUP BY 
        tag
),
TotalLargeLanguageModel AS (
    SELECT 
        COUNT(DISTINCT Id) AS total_large_language_model_count
    FROM 
        CleanTags
    WHERE 
        tag = 'federated-learning'
),
TotalTags AS (
    SELECT 
        tag, 
        COUNT(DISTINCT Id) AS total_tag_count
    FROM 
        CleanTags
    GROUP BY 
        tag
)
SELECT 
    tc.tag,
    (tc.cooccurrence_count / CAST(tll.total_large_language_model_count AS FLOAT)) AS tag_significance_threshold
FROM 
    TagCooccurrence tc
    JOIN TotalLargeLanguageModel tll ON 1=1
    JOIN TotalTags tt ON tc.tag = tt.tag
WHERE 
    (tc.cooccurrence_count / CAST(tll.total_large_language_model_count AS FLOAT)) >= 0.001 -- Adjust threshold if needed
ORDER BY 
    tag_significance_threshold DESC;
