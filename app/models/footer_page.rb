class FooterPage < ApplicationRecord
  enum status: {hidden: 0, shown: 1}
  enum page_type: {'Company Info': 0, 'Contributors': 1, 'Newsletter': 2}
end
