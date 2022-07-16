ALTER TABLE reservations DROP KEY event_id_and_sheet_id_idx;
ALTER TABLE reservations
ADD KEY event_id_and_sheet_id_idx (event_id, sheet_id);