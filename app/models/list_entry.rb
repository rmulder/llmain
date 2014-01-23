class ListEntry < ActiveRecord::Base

  #todo: make these commentable
  #todo: implement additional type of thing that can be on lists (eg deals) and constrain lists to a type of thing they can contain

  #set_inheritance_column :type

  #belongs_to :entry, :polymorphic => true
  #belongs_to :entry, :class_name => 'Business', :foreign_key => 'entry_business_id'
  belongs_to :owner, :polymorphic => true
  has_many :list_entry_lists
  has_many :lists, :through => :list_entry_lists
  has_one :comment

end
