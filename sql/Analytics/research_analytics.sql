-- 6. Clinical Trial Funnel
-- Insight: Tracks the progress of drugs through trial phases.
CREATE MATERIALIZED VIEW analytics.mv_clinical_trial_funnel AS
SELECT 
    ct.phase,
    ct.status,
    COUNT(ct.trial_id) AS number_of_trials,
    COUNT(tp.participant_id) AS total_participants_enrolled
FROM research.clinical_trials ct
LEFT JOIN research.trial_participants tp ON ct.trial_id = tp.trial_id
GROUP BY ct.phase, ct.status
ORDER BY ct.phase;