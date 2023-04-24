require '../rails_helper.rb'

RSpec.describe BoardPolicy do
  let(:user) { instance_double(User, role: role) }
  let(:board) { instance_double(Board) }

  context "when user is an admin" do
    let(:role) { instance_double(Role, name: "admin") }
    let(:policy) { BoardPolicy.new(user, board) }

    it "allows creating a board" do
      expect(policy.create?).to eq(true)
    end

    it "allows showing a board" do
      expect(policy.show?).to eq(true)
    end

    it "allows updating a board" do
      expect(policy.update?).to eq(true)
    end

    it "allows deleting a board" do
      expect(policy.destroy?).to eq(true)
    end
  end

  context "when user is a manager" do
    let(:role) { instance_double(Role, name: "manager") }
    let(:policy) { BoardPolicy.new(user, board) }

    it "allows creating a board" do
      expect(policy.create?).to be_truthy
    end

    it "allows showing a board" do
      expect(policy.show?).to be_truthy
    end

    it "allows updating a board" do
      expect(policy.update?).to be_truthy
    end

    it "does not allow deleting a board" do
      expect(policy.destroy?).to be_falsey
    end
  end

  context "when user is a staff member" do
    let(:role) { instance_double(Role, name: "staff") }
    let(:policy) { BoardPolicy.new(user, board) }

    it "allows creating a board" do
      expect(policy.create?).to be_truthy
    end

    it "allows showing a board" do
      expect(policy.show?).to be_truthy
    end

    it "does not allow updating a board" do
      expect(policy.update?).to be_falsey
    end

    it "does not allow deleting a board" do
      expect(policy.destroy?).to be_falsey
    end
  end
end