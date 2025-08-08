#Praat script by Ted Kye and Maida Percival, 2024
#This script creates a Praat picture from a user-specified wav file and textgrid.

beginPause: "User input"
	#Here are two example directories, one for Mac and one for Windows. Replace them with your own. 
	#word: "homedir", "/Users/maida/Dropbox/Maida-dissertation/Oromo/stimuli/"
	word: "homedir", "E:\Backup\Praat\Scripts\Pictures\botch_waveformsoundfile\"
	#Fill in the name of the textgrid and wav file (without the .wav and .TextGrid appended)
	word: "wav_name", ""
	word: "tg_name", ""
	comment: "pic_x_right can be lowered or raised to change the horizontal width of the praat picture"
	positive: "pic_x_left", 1
	positive: "pic_x_right", 5
	comment: "These are the default values for the coordinates of the waveform."
	positive: "wave_y_top", 1
	positive: "wave_y_bottom", 2
	comment: "These are the default values for the coordinates of the spectrogram."
	positive: "spec_y_top", 2
	positive: "spec_y_bottom", 3
	comment: "For text_y_bottom: keep 3.25 for a textgrid of one tier." 
	comment: "If it's two tiers, specify 3.5; if three tiers, 3.75."
	positive: "text_y_top", 2
	positive: "text_y_bottom", 3.25
	comment: "Frequency range for spectrogram"
	positive: "spec_freq", 7000
	comment: "Dynamic range for the spectrogram:"
	positive: "dynamic_range", 40
	comment: "Amplitude range (specify the absolute values of the minimum and maximum amplitudes)"
	positive: "minamp", 0.5
	positive: "maxamp", 0.5
	comment: "F0 range for pitch (specify the speaker's minimum and maximum):"
	positive: "minF0", 80
	positive: "maxF0", 250
endPause: "Continue", 1

Erase all

wav = Read from file: homedir$+wav_name$+".wav"
tg = Read from file: homedir$+tg_name$+".TextGrid"

selectObject: wav

Select inner viewport: pic_x_left, pic_x_right, wave_y_top, wave_y_bottom

Colour: "black"

end = Get end time
beg = Get start time

Draw: beg+0.005, end-0.005, -minamp, maxamp, "no", "curve"
Draw inner box

Select inner viewport: pic_x_left, pic_x_right, spec_y_top, spec_y_bottom

wav_spec = To Spectrogram: 0.005, spec_freq, 0.002, 20.0, "Gaussian"

Paint: beg+0.005, end-0.005, 0.0, 0.0 (= all), 100.0, "yes", dynamic_range, 6.0, 0.0, "no"
Draw inner box
Marks left every: 1, spec_freq, "yes", "yes", "no"
Text left: "yes", "Frequency (Hz)"

removeObject: wav_spec

selectObject: wav

wav_pitch = To Pitch (ac): 0.0, minF0, 15, "no", 0.05, 0.65, 0.06, 0.35, 0.14, maxF0

Colour: "blue"
Speckle size: 1.5
Speckle: 0, 0, minF0, maxF0, "no"

#Marks right every: 1, maxF0, "yes", "yes", "no"
One mark right: minF0, "yes", "yes", "no", ""
One mark right: maxF0, "yes", "yes", "no", ""
Text right: "yes", "Pitch (Hz)"

removeObject: wav_pitch

Colour: "black"

selectObject: tg

Select inner viewport: pic_x_left, pic_x_right, text_y_top, text_y_bottom

Draw: beg+0.005, end-0.005, "yes", "yes", "no"
Draw inner box
One mark bottom: 0.005, "no", "yes", "no", "0"
endtime = end-0.005
#this commented out line rounds the seconds to the nearest thousandth but the rounded number doesn't show up if you have to round up, so we've commented it out for now until we find a fix. You'll have to crop out the fourth decimal if needed.
#endtime = number(fixed$(endtime,3))
Marks bottom every: 1, endtime, "yes", "yes", "no"

Text bottom: "no", "Time (s)"

Select inner viewport: pic_x_left, pic_x_right, wave_y_top, text_y_bottom

removeObject: wav
removeObject: tg

 
