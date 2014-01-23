class ListEntryList < ActiveRecord::Base
  set_table_name "list_entries_lists"
  belongs_to :list
  belongs_to :list_entry
end
