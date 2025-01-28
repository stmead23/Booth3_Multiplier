onbreak {resume}

if [file exists work] {
    vdel -all
}

vlib work

vlog mult_and_add_tb.sv mult_and_add.sv

vsim -novopt work.tb

add wave -bin /tb/x
add wave -bin /tb/y
add wave -bin /tb/result

run -all