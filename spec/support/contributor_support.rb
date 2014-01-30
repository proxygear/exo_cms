include Warden::Test::Helpers

module ContributorSupport
  extend ActiveSupport::Concern

  included do
    class_eval do
      extend ContributorSupport::ClassMethods
    end
  end

  module ClassMethods
    def anonymous!
      before(:each) { logout }
    end

    def logged_contributor! options={}, &block
      let(:contributor_pass)  { build_pass options, &block }
      let(:contributor)       { contributor_pass.contributor }
      before(:each)           do
        instance_exec contributor, &block if block
        contributor_pass.sign_in
      end
    end
  end

  def build_pass opt=nil, &block
    opt ||= {}
    opt[:password] = 'testtest' unless opt[:password]
    decorator = opt.delete(:decorator) || ContributorPassDecorator
    target = opt.delete(:target) || :contributor
    object = create target, opt
    decorator.new(object).tap do |k|
      k.app = self
      k.password = opt[:password]
    end
  end
end

class ContributorPassDecorator
  attr_accessor :contributor, :app

  def initialize contributor
    self.contributor = contributor
  end

  def sign_in
    app.login_as contributor, scope: :contributor
  end
  
  def visit path
    app.visit path
  end

  def to_s
    {email: email, password: @_password}.to_s
  end
  
  def password= p
    @_password = p
    contributor.password = p
  end

  def password
    @_password
  end

  def locale= l
    @_locale = l
  end

  def locale
    @_locale
  end
end