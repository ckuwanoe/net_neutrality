require "fcc"
class PostToFccJob
  @queue = :fcc

  def self.perform(commenter_id)
    commenter = Commenter.find(commenter_id)
    if Fcc.add_comment(commenter.name, commenter.email, commenter.address_line_1, commenter.zip, commenter.comment)
      commenter.update(sent_to_fcc: true)
    end
  end  
end