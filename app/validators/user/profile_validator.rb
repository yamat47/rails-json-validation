class User::ProfileValidator < ActiveModel::Validator
  def validate(record)
    profile = Profile.new(record.profile.symbolize_keys)

    return if profile.valid?

    # profileのバリデーションエラーをUserにマージする。
    #
    # Userに直接定義されているカラムとキーが被らないように
    # 'profile_'付きのキーにしておく。
    profile.errors.each do |attribute, message|
      record.errors.add("profile_#{attribute}", message)
    end
  end

  class Profile
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :nickname, :string
    attribute :editor, :string
    attribute :website, :string

    validates :nickname, length: { in: 4..12 }
    validates :editor, inclusion: { in: %w(vim emacs) }
    validates :website, presence: true, url: { allow_blank: true }
  end
end
