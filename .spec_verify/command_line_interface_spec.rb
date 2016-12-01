require 'blackjack/command_line_interface'

describe CommandLineInterface do
  let(:stdin) { double(:stdin) }
  let(:stdout) { double(:stdout, puts: nil) }
  let(:game) { double(:game, add_players: nil) }

  describe "describing the game", focus: true do
    it "announces a hit card" do
      king = double(:king, symbol: :king)

      allow(stdin).to receive(:gets).and_return("1", "hit", "stand")

      allow(game).to receive(:over?).and_return(false, false, true)
      allow(game).to receive(:winner?).and_return(true)
      allow(game).to receive(:winner_name).and_return(0)
      allow(game).to receive(:play_move).and_return(king, nil)

      expect(stdout).to receive(:puts).with("Dealt king")

      described_class.new(stdin, stdout, game)
    end

    it "announces the winner", focus: true do
      allow(stdin).to receive(:gets).and_return("1", "stand")
      allow(game).to receive(:over?).and_return(false, true)
      allow(game).to receive(:winner?).and_return(true)
      allow(game).to receive(:play_move)
      allow(game).to receive(:winner_name).and_return(0)

      expect(stdout).to receive(:puts).with("Player 0 won")

      described_class.new(stdin, stdout, game)
    end

    it "announces there's no winner if there's no winner", focus: true do
      allow(stdin).to receive(:gets).and_return("1", "stand")
      allow(game).to receive(:over?).and_return(true)
      allow(game).to receive(:winner?).and_return(false)
      allow(game).to receive(:play_move)

      expect(stdout).to receive(:puts).with("No winner")

      described_class.new(stdin, stdout, game)
    end
  end

  describe "playing a game", focus: true do
    it "plays turns until there's a winner" do
      allow(stdin).to receive(:gets).and_return("1", "stand")
      allow(game).to receive(:over?).and_return(false, true)
      allow(game).to receive(:winner?).and_return(true)
      allow(game).to receive(:play_move)
      allow(game).to receive(:winner_name).and_return(0)

      expect(stdout).to receive(:puts).with("Player 0 won")

      described_class.new(stdin, stdout, game)
    end
  end
end
