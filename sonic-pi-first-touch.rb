
clap = "/Users/nakanotomoya/Desktop/sonic-pi/clap/OS_BD_clap_superfly.wav"

use_bpm 135
live_loop :met do
  sleep 1
end


loop_break = false
##| loop_break = true

drum_break = false
drum_break = true


### Kick
live_loop :kick, sync: :met do
  ##| stop
  
  stop if drum_break
  
  if "x---x---x---xx--".ring.tick == "x" then
    sample :bd_tek, amp: 0.8
  end
  sleep 0.25
end

### clap
live_loop :clap, sync: :met do
  ##| stop
  
  stop if drum_break
  sleep 1
  sample clap, amp: 0.7
  sleep 1
end

### hihat
live_loop :hh, sync: :met do
  ##| stop
  
  stop if drum_break
  
  case "xxo-xxo-xxo-xxo-".ring.tick
  when "x" then
    sample :drum_cymbal_closed, amp: 0.2, sustain: 0.15
  when "o" then
    sample :drum_cymbal_open, amp: 0.15, sustain: 0.15
  end
  sleep 0.25
end
1

### percussion
live_loop :percussion, sync: :met do
  ##| stop
  
  stop if drum_break
  
  if "--xx-x----xx-x--".ring.tick == "x" then
    sample :perc_snap2, release: 0.2, amp: 0.1
  end
  sleep 0.25
end


### bass
live_loop :bass, sync: :met do
  stop
  
  stop if loop_break
  
  attack = 0
  amp = 0.7
  sustain = 0.25
  
  notes = [:gs2, :a2, :b2, :cs3]
  notes = [:a2, :b2, :cs3, :gs2]
  pattern = "x--x--x-x--x--x-x--x--x-x--x--x-"
  
  index = (look + 1) / 8 % 4
  
  use_synth :fm
  if pattern.ring.tick == "x" then
    play notes.ring[index], sustain: sustain, amp: amp, attack: attack
  end
  sleep 0.25
end

### keyboard
live_loop :keyboard, sync: :met do
  ##| stop
  
  stop if loop_break
  
  use_synth :fm
  
  chord1 = [:gs3, :e4, :gs4, :b4, :e5]
  chord2 = [:a3, :e4, :gs4, :b4, :e5]
  chord3 = [:b3, :a4, :cs5, :e5, :gs5]
  chord4 = [:cs3, :a4, :cs5, :e5, :b5]
  
  pattern = "x--x----x--x----x--x----x--x----"
  pattern = "xxxx----xxxx----xxxx----xxxx----"
  
  release = 1
  release = 0.15
  
  
  chords = [chord1, chord2, chord3, chord4]
  
  index = (look + 1) / 8 % 4
  
  if pattern.ring.tick == "x" then
    play_chord chords.ring[index], release: release
  end
  sleep 0.25
end

### Piano
with_fx :reverb, mix: 0.5, room: 0.6 do
  live_loop :piano, sync: :met do
    stop
    
    stop if loop_break
    
    use_synth :piano
    
    chord1 = [:a3, :e4, :gs4, :b4, :e5]
    chord2 = [:b3, :a4, :cs5, :e5, :gs5]
    chord3 = [:cs4, :e4, :gs4, :e5, :b5]
    chord4 = [:gs3, :e4, :gs4, :b4, :e5]
    chords = [chord1, chord2, chord3, chord4]
    
    release = 1
    
    index = (look + 1) / 8 % 4
    
    case "x-y-xy-x-y-xy-x-x-y-xy-x-y-xy-x-".ring.tick
    when "x" then
      play_chord chords.ring[index].take(3), release: release
    when "y" then
      play_chord chords.ring[index][3..4], release: release
    end
    sleep 0.25
  end
end

### pluck
with_fx :reverb, mix: 0.5, room: 0.6 do
  live_loop :pluck, sync: :met do
    stop
    
    stop if loop_break
    
    use_synth :piano
    case "x-y-xy-x-y-xy-x-".ring.tick
    when "x" then
      play :e4, amp: 0.4
    when "y" then
      play chord(:e5, :M).choose, amp: 0.4, release: 0.3
    end
    sleep 0.25
  end
end

live_loop :melo, sync: :met do
  note, velocity = sync "/midi:launchpad_x_lpx_midi_out:8/note_on"
  synth :piano, note: note
end
