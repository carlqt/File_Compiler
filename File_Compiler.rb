require 'pathname'
require 'tk'
require 'tkextlib/tile'
# Method definitions

def exit_app
  exit
end

def message(msg)
  msgBox = Tk.messageBox(
  'type'    => "ok",  
  'icon'    => "info", 
  'title'   => "Warning",
  'message' => msg
  )
end

def myproc(input, output, fname)
puts $chkRemoveDuplicate.variable

  # curr_directory = Dir.pwd << '\sample'
  curr_directory = input.get.tr('\\', '/')
  output_directory = output.get.tr('\\', '/')
  out_filename = fname.get + '.txt'
  out_filename = output_directory + '/' + out_filename

  #setting up message to be displayed in the message box
  unless File.exists?(curr_directory)
    msgdata = "Input folder is not a valid folder path"
  else
    unless File.exists?(output_directory)
      msgdata = "Output folder is not a valid folder path"
    end
  end

  # puts output_directory

  if File.exists?(curr_directory) && File.exists?(output_directory)

    File.open(out_filename, 'w') do |f|

      Pathname.glob(curr_directory << '/*.txt') do |file|
        file.each_line { |line| f.puts line }

      end

    end

    exit
  else
    # puts File.directory?(curr_directory)
    message(msgdata)
  end
  #exit
end



# -----> End of method definitons



# <---- Ruby GUI TK

root = TkRoot.new do 
  title "Hello, World!"
  minsize(400,400)
end

TkLabel.new(root) do  
  text 'Input Folder:'
  pack("side" => "left",  "padx"=> "20", "pady"=> "15")
  place('relx'=>0.0,'rely'=>0.0)
end

txtInput = TkEntry.new(root) do
  takefocus 1
  focus
  width 40
  borderwidth 1
  pack("side" => "left",  "padx"=> "5", "pady"=> "5")
  place('relx'=>0.25,'rely'=>0.0)
end

TkLabel.new(root) do  
  text 'Output Folder:'
  pack("side" => "left",  "padx"=> "21", "pady"=> "14")
  place('relx'=>0.0,'rely'=>0.1)
end

txtOutput = TkEntry.new(root) do
  takefocus 1
  width 40
  borderwidth 1
  pack("side" => "left",  "padx"=> "5", "pady"=> "5")
  place('relx'=>0.25,'rely'=>0.1)
end

TkLabel.new(root) do  
  text 'Filename:' 
  pack("side" => "left",  "padx"=> "22", "pady"=> "13") 
  place('relx'=>0.0,'rely'=>0.20)
end  

txtFilename = TkEntry.new(root) do
  takefocus 1
  width 40
  borderwidth 1
  pack("side" => "left",  "padx"=> "5", "pady"=> "5")
  place('relx'=>0.25,'rely'=>0.20)
end

btn_OK = TkButton.new(root) do
  text "OK"
  borderwidth 5
  state "normal"
  font TkFont.new('times 10 bold')
  activebackground "blue"
  relief      "groove"
  command (proc {myproc(txtInput,txtOutput,txtFilename)})
  pack("side" => "right",  "padx"=> "50", "pady"=> "10")
  place('x'=>10, 'y'=>120)
end

btn_exit = TkButton.new(root) do
  text "Cancel"
  borderwidth 5
  state "normal"
  font TkFont.new('times 10 bold')
  activebackground "blue"
  relief      "groove"
  command (proc {exit_app})
  pack("side" => "right",  "padx"=> "50", "pady"=> "10")
  place('x'=>70, 'y'=>120)
end


$chkRemoveDuplicate = TkCheckButton.new(root) do
  text "Remove Duplicate"
  indicatoron true
  place('x' => 250, 'y'=> 120)
end

$chkFilter_10_digits = TkCheckButton.new(root) do
  text "Filter 10 digit numbers"
  place('x' => 250, 'y'=> 150)
end
# ---> End of Ruby GUI

btn_OK.bind('Enter', proc {puts 'SEX'})
# puts (File.directory?(txtInput.get << '/sample') ? btn_OK.command(proc {myproc(txtInput)}) : "no folder found")
Tk.mainloop



