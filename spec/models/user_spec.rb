require 'rails_helper'

RSpec.describe User do
  describe 'profileのバリデーション' do
    context 'profileが不正な値のとき' do
      where(:profile) do
        [
          nil,
          {},
          { nickname: nil, editor: 'vim', website: 'https://github.com/yamat47' }, # nicknameがnil
          { nickname: 'yamat47', editor: nil, website: 'https://github.com/yamat47' }, # editorがnil
          { nickname: 'yamat47', editor: 'vim', website: nil }, # websiteがnil
          { nickname: 'dog', editor: 'vim', website: 'https://github.com/yamat47' }, # nicknameが短い
          { nickname: 'superlongnickname', editor: 'vim', website: 'https://github.com/yamat47' }, # nicknameが長い
          { nickname: 'yamat47', editor: 'Visual Studio Code', website: 'https://github.com/yamat47' }, # editorが候補の中にない
          { nickname: 'yamat47', editor: 'vim', website: 'htps://github.com/yamat47' }, # websiteの形式に沿っていない（htpsで始まっている）
        ]
      end

      with_them do
        it { expect(User.new(profile: profile)).to be_invalid }
      end
    end

    context 'profileが正しい値のとき' do
      where(:profile) do
        [
          { nickname: 'yamat47', editor: 'vim', website: 'https://github.com/yamat47' },
          { nickname: 'yamat47', editor: 'emacs', website: 'https://github.com/yamat47' }
        ]
      end

      with_them do
        it { expect(User.new(profile: profile)).to be_valid }
      end
    end

    context 'profileに余計なパラメータが付いているとき' do
      it 'initializeをすると例外が発生する' do
        expect { User.new(nickname: 'yamat47', editor: 'vim', website: 'https://github.com/yamat47', birthday: Date.current) }.to raise_error ActiveModel::UnknownAttributeError
      end
    end
  end
end
