# == Schema Information
#
# Table name: follows
#
#  id              :bigint(8)        not null, primary key
#  blocked         :boolean          default(FALSE), not null
#  followable_type :string(255)      not null
#  follower_type   :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  followable_id   :bigint(8)        not null
#  follower_id     :bigint(8)        not null
#
# Indexes
#
#  fk_followables                                      (followable_id,followable_type)
#  fk_follows                                          (follower_id,follower_type)
#  index_follows_on_followable_type_and_followable_id  (followable_type,followable_id)
#  index_follows_on_follower_type_and_follower_id      (follower_type,follower_id)
#

class Follow < ActiveRecord::Base
  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" and "follower" interface
  belongs_to :followable, polymorphic: true
  belongs_to :follower,   polymorphic: true

  def block!
    update_attribute(:blocked, true)
  end
end
