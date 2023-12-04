:se_bpm 136

### SAMPLES ###
sample_1 = "/Users/nakanotomoya/Splice/sounds/packs/Paradox - Progressive House Vocals/PLX_-_Paradox_-_Progressive_House_Vocals/one-shots/fx_one-shots/PLX_PPHV_vocal_fx_reverse_Dmin.wav"
sample_2 = "/Users/nakanotomoya/Splice/sounds/packs/For The Soul/loops/Vocals/PJ_FTS_71_kit_loop_Harmony_Peace_Love_Happiness_Vocal_Cmaj.wav"
sample_3 = "/Users/nakanotomoya/Splice/sounds/packs/Vocal Tech House/Dropgun_Samples_-_Vocal_Tech_House/Loops/Vocal_Loops/Party/DS_VTH_125_vocal_hook_female_loop_party_verse_wet_Cmaj.wav"


live_loop :met do
  sleep 1
end

### KICK ###
live_loop :kick, sync: :met do
  ##| stop
  
  pattern = "x---x---x---x---"
  pattern = "--x---x--x-x--x-x--x--x-xx-x---x"
  
  amp = 1
  
  if pattern.ring.tick == "x" then
    sample :bd_tek, amp: amp
  end
  sleep 0.25
end


### HIHAT ###
live_loop :hihat, sync: :met do
  ##| stop
  
  pattern = "xxo---x---x---x-"
  pattern = "xxo-xxo-xxo-xxo-"
  case pattern.ring.tick
  when "x" then
    sample :drum_cymbal_closed, amp: 0.3, sustain: 0.1
  when "o" then
    sample :drum_cymbal_open, amp: 0.1, sustain: 0.1
  end
  sleep 0.25
end


### SNARE/CLAP ###
live_loop :clap, sync: :met do
  ##| stop
  
  sleep 1
  sample :drum_snare_soft, release: 0.5, amp: 0.5
  sample :elec_hi_snare, release: 0.4, amp: 0.5
  sleep 1
end

### COWBELL ###
live_loop :cowbell, sync: :met do
  ##| stop
  
  pattern = "---x---------x-x"
  if pattern.ring.tick == "x"
    sample :elec_pop, release: 0.5, amp: 0.25
  end
  sleep 0.25
end

### SCRATCH ###
live_loop :scratch, sync: :met do
  ##| stop
  
  pattern = "----------xx----"
  if pattern.ring.tick == "x"
    sample :vinyl_scratch, release: 0.1, amp: 0.15
  end
  sleep 0.25
end



### BASS ###
live_loop :bass, sync: :met do
  ##| stop
  
  notes = [:f2, :g2, :a2, :e2, :f2, :g2, :a2, :b2]
  pattern = "--x---x--x-x--x-x--x--x-xx-x---x"
  index = (look + 1) / 16 % notes.length
  amp = 1
  
  use_synth :fm
  if pattern.ring.tick == "x"
    play notes[index], amp: amp, release: 0.4
  end
  sleep 0.25
end

### SUB BASS ###
live_loop :subbass, sync: :met do
  ##| stop
  
  notes = [:f1, :g1, :a1, :e1, :f1, :g1, :a1, :b1]
  pattern = "xxxxxxxxxxxxxxxx"
  index = (look + 1) / 16 % notes.length
  amp = 1
  
  use_synth :subpulse
  if pattern.ring.tick == "x"
    play notes[index], amp: amp, release: 0.2
  end
  sleep 0.25
end

### CHORDS ###
live_loop :chord, sync: :met do
  ##| stop
  
  chords =
    [chord(:f3, 'maj9'),
     chord(:g3, '6*9'),
     chord(:a3, 'm9'),
     chord(:e3, 'm9'),
     chord(:f3, 'maj9'), chord(:g3, '6*9'), chord(:a3, 'm9'), chord(:b3, 'm7-9')]
    pattern = "--xx--x--x-x--x-"
  amp = 0.7
  release = 0.4
  
  index = (look + 1) / 16 % chords.length
  use_synth :saw
  if pattern.ring.tick == "x"
    play chords[index], amp: amp, release: release
  end
  sleep 0.25
end

### PLUCK ###
live_loop :key, sync: :met do
  ##| stop
  
  notes = [:g5, :c5, :d5, :g4]
  index = (look + 1) / 16 % notes.length
  tick
  use_synth :sine
  
  play notes.look, amp: 0.15, release: 0.15, decay: 0.5, decay_level: 0.01, pan: -0.5
  sleep 0.25
end

### PLUCK ###
live_loop :pluck, sync: :met do
  ##| stop
  
  use_synth :saw
  notes = scale(:a3, :minor_pentatonic, num_octaves: 4).mirror
  ##| tick
  play notes.look, amp: 0.3, release: 0.15, pan: 0.5
  sleep 0.25
end

### PERCUSSIVE NOISE ###
live_loop :percussive_noise, sync: :met do
  ##| stop
  
  slice = rand_i(16)
  slice_size = 0.125/2/2
  start = slice * slice_size
  finish = start + slice_size
  sample sample_2, start: start, finish: finish, amp: 0.25, beat_stretch: 4
  sleep 0.25
end

### VOICE ###
live_loop :vocal_sweep, sync: :met do
  ##| stop
  
  sample sample_1, rate: 1, amp: 0.2, start: 0.5, sustain: 4
  sleep 2
end

### VOCAL ###
live_loop :vocal_chops, sync: :met do
  ##| stop
  
  slice = rand_i(32)
  slice_size = 0.125/2/2
  start = slice * slice_size
  finish = start + slice_size
  if rand_i_look % 2 == 1 then
    sample sample_3, start: start, finish: finish, amp: 0.15, release: 0
  end
  sleep 0.25
end


