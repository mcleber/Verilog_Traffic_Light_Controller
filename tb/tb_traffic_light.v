// Define the time precision for the simulation. 
// That is, the time unit is in nanoseconds (1ns) and the precision unit is in picoseconds (1ps).
`timescale 1ns / 1ps

// Testbench module to test the traffic_light module
module tb_traffic_light;

    // Declaration of input and output signals for the testbench
    reg Clock;            // 'Clock' is an input signal of type 'reg', which simulates the clock signal
    wire R_LED, Y_LED, G_LED; // 'R_LED', 'Y_LED', and 'G_LED' are output signals of the traffic_light module

    // Instantiating the 'traffic_light' module (unit under test - UUT)
    // 'uut' stands for "unit under test", meaning the unit we are testing.
    traffic_light uut (
        .Clock(Clock),   // Connecting the 'Clock' signal from the testbench to the input 'Clock' of the traffic_light module
        .R_LED(R_LED),   // Connecting the 'R_LED' signal from the testbench to the output 'R_LED' of the traffic_light module
        .Y_LED(Y_LED),   // Connecting the 'Y_LED' signal from the testbench to the output 'Y_LED' of the traffic_light module
        .G_LED(G_LED)    // Connecting the 'G_LED' signal from the testbench to the output 'G_LED' of the traffic_light module
    );

    // Clock Generator
    // The 'initial' block below creates a simulated clock.
    initial begin
        Clock = 0;  // Initialize the 'Clock' signal to 0 (this will make the first clock cycle)
        forever #5 Clock = ~Clock;  // The 'forever' command creates a loop that toggles the 'Clock' signal every 5 ns
        // Every 5 ns, the 'Clock' signal alternates between 0 and 1, creating a 10 ns clock cycle
        // Which results in a frequency of 100 MHz (1 / 10 ns = 100 MHz)
    end

    // Initialization and Simulation
    // This 'initial' block manages the simulation of the testbench
    initial begin
        // The '$monitor' command prints the value of the LEDs on every state change.
        // The '$time' function returns the current simulation time.
        // Every time the value of R_LED, Y_LED, or G_LED changes, the line below will be printed.
        $monitor("Time: %t, R_LED: %b, Y_LED: %b, G_LED: %b", $time, R_LED, Y_LED, G_LED);
        
        // The simulation will run for 1500 clock cycles. Since the clock is 100 MHz (10 ns per cycle),
        // 1500 cycles correspond to 15,000 ns, which is 15 microseconds of simulation.
        #1500;

        // The '$finish' command ends the simulation after the specified time
        $finish;
    end
endmodule

