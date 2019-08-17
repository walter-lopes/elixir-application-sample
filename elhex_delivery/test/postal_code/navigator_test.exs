defmodule ElhexDelivery.PostalCode.NavigatorTest do
    use ExUnit.Case
    alias ElhexDelivery.PostalCode.Navigator

    doctest ElhexDelivery

    describe "get_distance format tests" do
        test "postal code strings" do
            distance = Navigator.get_distance("94062", "94104")
            assert is_float(distance)
        end

        test "postal code integers" do
            distance = Navigator.get_distance(94062, 94104)
             assert is_float(distance)
        end

        test "postal code mixed string and integers" do
            distance = Navigator.get_distance("94062", 94104)
            assert is_float(distance)
        end

        @tag :capture_log
        test "postal code unexpected format" do
            navigator_pid = Process.whereis(:postal_code_navigator)
            reference = Process.monitor(navigator_pid)
            catch_exit do
                Navigator.get_distance("94062", 9410.023)
            end
            assert_received({:DOWN, ^reference, :process, ^navigator_pid, {%ArgumentError{}, _}}) 
        end
    end

    describe "get_distance (actual distance)" do
        test "distance_between_rwc_and_sf" do
            distance = Navigator.get_distance(94062, 94104)
            assert distance == 26.75
        end

         test "distance_between_sf_and_nyc" do
            distance = Navigator.get_distance(94104, 10112)
            assert distance == 2565.28
        end

         test "distance_between_mnpls_and_austin" do
            distance = Navigator.get_distance(55401, 78703)
            assert distance == 1044.08
        end
    end
end