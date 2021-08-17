require 'rails_helper'

RSpec.describe Todo, type: :model do
  let(:todo) { todo = Todo.new(name: "My Amazing TODO") }
    it "is invalid without a name" do
      expect(todo).to be_valid
      todo.name = nil
      expect(todo).not_to be_valid
  end
end
