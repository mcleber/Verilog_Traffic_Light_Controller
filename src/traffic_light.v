// Definition of the traffic_light module, which simulates a traffic light with 3 LEDs: R_LED (red), Y_LED (yellow), G_LED (green)
module traffic_light(
    input Clock,           // Input clock signal (defined as an external clock)
    output reg R_LED,     // Red LED
    output reg Y_LED,     // Yellow LED
    output reg G_LED      // Green LED
);
/********** COUNTER **********/
parameter Clock_Frequency = 27_000_000;  // 27 MHz crystal frequency. Used to generate counts based on real time
parameter Count_1s = Clock_Frequency - 1;  // To count 1 second, the maximum value is 26,999,999 (27 MHz - 1)
parameter Count_0_5s = Clock_Frequency / 2 - 1; // To count 0.5 seconds, the maximum value is 13,499,999 (27 MHz / 2 - 1)
reg [23:0] count_value_reg;  // 24-bit register used to store the time counter value
reg [1:0] state;             // Time sequence control, with 2 bits. Used to control what the system is doing (turning on, off, etc.)
reg [1:0] current_led;       // Current LED to be activated: 0 -> red, 1 -> yellow, 2 -> green
// Always block executed on the rising edge of the clock
always @(posedge Clock) begin
    // Increment the time counter. On each clock cycle, it is incremented until it reaches the 1-second value.
    if (count_value_reg < Count_1s) begin
        count_value_reg <= count_value_reg + 1'b1;  // Increment the counter
    end else begin
        count_value_reg <= 23'b0;  // Reset the counter after 1 second
    end
end
/********** LED ACTIVATION LOGIC **********/
always @(posedge Clock) begin
    case (state)  // Decodes the current system state using the 'state' variable
        // State 00: Turn on the LED for 1 second
        2'b00: begin
            // Check which LED is currently active (via 'current_led') and turn on the corresponding LED
            if (current_led == 2'b00) begin
                R_LED <= 1;  // Turn on the red LED
                Y_LED <= 0;  // Turn off the yellow LED
                G_LED <= 0;  // Turn off the green LED
            end else if (current_led == 2'b01) begin
                R_LED <= 0;  // Turn off the red LED
                Y_LED <= 1;  // Turn on the yellow LED
                G_LED <= 0;  // Turn off the green LED
            end else begin
                R_LED <= 0;  // Turn off the red LED
                Y_LED <= 0;  // Turn off the yellow LED
                G_LED <= 1;  // Turn on the green LED
            end
            state <= 2'b01;  // Move to the next state (turn off the LED)
        end
        
        // State 01: Turn off the LED after 0.5 seconds
        2'b01: begin
            // When the counter reaches 0.5 seconds (Count_0_5s), the current LED is turned off
            if (count_value_reg == Count_0_5s) begin
                case (current_led)  // Check which LED was activated to turn it off
                    2'b00: R_LED <= 0;  // Turn off the red LED
                    2'b01: Y_LED <= 0;  // Turn off the yellow LED
                    2'b10: G_LED <= 0;  // Turn off the green LED
                endcase
                state <= 2'b10;  // Move to the next state (wait for the counter to reset)
                current_led <= current_led + 1;  // Advance to the next LED (increment 'current_led')
                // If all LEDs were activated (current_led == 2'b10), restart the sequence
                if (current_led == 2'b10)
                    current_led <= 2'b00;  // Restart the LED counter (go back to the first LED)
            end
        end
        
        // State 10: Wait one clock cycle before returning to the turn-on state
        2'b10: begin
            state <= 2'b00;  // Return to the state of turning on the next LED
        end

        // Default: safe fallback for any undefined state
        default: begin
            state <= 2'b00;
            current_led <= 2'b00;
            R_LED <= 0;
            Y_LED <= 0;
            G_LED <= 0;
        end
        
    endcase
end
endmodule
