-- Trigger: insert_trigger

-- DROP TRIGGER insert_trigger ON public."<table_name>";

CREATE TRIGGER insert_trigger
    AFTER INSERT
    ON public."<table_name>"
    FOR EACH ROW
    EXECUTE PROCEDURE public.notify_insert_event();