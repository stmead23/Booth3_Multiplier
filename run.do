onbreak {resume}

if [file exists work] {
    vdel -all
}

vlib work

vlog booth3_tb.sv booth3.sv

vsim -novopt work.tb

add wave -bin /tb/x
add wave -bin /tb/y
add wave -bin /tb/result

run -all