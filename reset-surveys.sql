DELETE FROM answers;
ALTER SEQUENCE answers_id_seq RESTART WITH 1;

DELETE FROM columns;
ALTER SEQUENCE columns_id_seq RESTART WITH 1;

DELETE FROM dependencies;
ALTER SEQUENCE dependencies_id_seq RESTART WITH 1;

DELETE FROM dependency_conditions;
ALTER SEQUENCE dependency_conditions_id_seq RESTART WITH 1;

DELETE FROM question_groups;
ALTER SEQUENCE question_groups_id_seq RESTART WITH 1;

DELETE FROM questions;
ALTER SEQUENCE questions_id_seq RESTART WITH 1;

DELETE FROM response_sets;
ALTER SEQUENCE response_sets_id_seq RESTART WITH 1;

DELETE FROM responses;
ALTER SEQUENCE responses_id_seq RESTART WITH 1;

DELETE FROM rows;
ALTER SEQUENCE rows_id_seq RESTART WITH 1;

DELETE FROM survey_sections;
ALTER SEQUENCE survey_sections_id_seq RESTART WITH 1;

DELETE FROM survey_translations;
ALTER SEQUENCE survey_translations_id_seq RESTART WITH 1;

DELETE FROM surveys;
ALTER SEQUENCE surveys_id_seq RESTART WITH 1;

