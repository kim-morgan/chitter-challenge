require 'peep'

describe Peep do

  before do
    #Not sure how to stub this but at least one user is needed in the db in order to add peep
    DatabaseConnection.query("ALTER SEQUENCE users_id_seq RESTART WITH 1;")
    user = User.create("Kim", "kim-morgan", "kim_fake_email@gmail.com", "password123")
  end

  context "#create"
  it "should be able to create a peep" do
    peep = Peep.create('Hello everyone', 1)
    expect(peep).to be_a_kind_of Peep
    expect(peep.content).to eq "Hello everyone"
    expect(peep.user_id).to eq "1"
  end

  context "#all"
  it "should be able to list all peeps" do
    peep = Peep.create('First peep', 1)
    peep_2 = Peep.create('Second peep', 1)
    expect(Peep.all[0].content).to eq 'First peep'
    expect(Peep.all[1].content).to eq 'Second peep'
  end

  context "#sort_peeps"
  it "should be able to sort peeps by time" do
    peep_times = ["18:29:23 7 Dec 2021", "18:29:23 7 Dec 2020", "18:29:23 10 Dec 2021", "12:29:23 10 Dec 2021"]
    expect(Peep.sort_peeps(peep_times)).to eq ["18:29:23 10 Dec 2021", "12:29:23 10 Dec 2021", "18:29:23 7 Dec 2021", "18:29:23 7 Dec 2020"]
  end

  context "#sanitize"
  it "should be able to sanitize string input from single quotes to put into sql" do
    expect(Peep.sanitize("don't and won't")).to eq "don''t and won''t"
  end

end