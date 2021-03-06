require 'factory_girl'
require 'factories/factories'
class FactoryLoader 
  
  def self.up
    self.create_users
    self.create_projects
    puts "Factories Loaded!"
  end
  
  def self.down
    [Task, Project, User].each(&:delete_all)
    puts "Factories Unloaded!"
  end
  
  
  def self.create_users
    5.times do |n|
      u = Factory.create(:user)
      u.confirm_email!
    end
  end
  
  
  def self.create_projects
    users = User.all
    users.each do |user|
      10.times do |i|
        p = Factory.create(:project, :owner => user, :users => [user])
        self.create_tasks(p, user)
        self.create_wall_posts(p)
      end
    end
  end
  
  def self.create_tasks(project, user)
    5.times do |i|
      task = Factory.create(:task, :project => project, :owner => user, :assignee => user)
      5.times do |n|
        t = Factory.create(:task, :project => project, :parent => task.id, :owner => user, :assignee => user)
        2.times do |nn|
          Factory.create(:task, :project => project, :parent => t.id, :owner => user, :assignee => user)
        end
      end
    end
  end
  
  def self.create_wall_posts(project)
    User.all.each do |user|
      Factory.create(:wall, :author => user, :project => project)
    end
  end
  
  
end