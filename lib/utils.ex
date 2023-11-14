# RESERVED KEYWORDS:
# true, false, nil
# when, and, or, not, in
# fn
# do, end, catch, rescue, after, else

###############################################################################
# FUNCTION INDEX:
# alphabet()
# alphanumeric()
# type()
###############################################################################
defmodule Utils do
    @moduledoc """
    Basic extensions for Elixir.
    """
###############################################################################

    # builtin equivalent -> letter = Enum.to_list(?A..?Z)
    def alphabet(option \\ "lower") do
        @doc """
        Returns a string of the English alphabet.
        -----------
        PARAMETERS:
        -----------
        option: str
            Default value returns the alphabet in lowercase; use "upper" to
            return uppercase
        ------
        USAGE:
        ------
        # default option is lowercase
        Utils.alphabet() -> "abcdefghijklmnopqrstuvwxyz"
        Utils.alphabet("upper") -> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        """
        cond do
            option === "lower" ->
                ?a..?z |> Enum.to_list |> List.to_string
            option === "upper" ->
                ?a..?z |> Enum.to_list |> List.to_string |> String.upcase
            true ->
                raise ArgumentError, message: "Option must be 'upper'."
            end
        end

###############################################################################

    def alphanumeric(values) do
        @doc """
        Concatenates all elements of a list into a single string.
        -----------
        PARAMETERS:
        -----------
        values: list
            list of values to concatenate
        ------
        USAGE:
        ------
        # input type must be list
        Utils.alphanumeric([1, "A", 3]) -> "1A3"
        """
        # assert input type was list
        if type(values) !== "list" do
            raise ArgumentError, message: "Input type must be list."
        end
        # convert all list elements to strings and concatenate
        Enum.map(values, fn(el) -> to_string(el) end) |> Enum.join()
    end

###############################################################################

    @doc """
    >>> TESTED 4/30/2023
    Generates a random string per option argument.
    -----------
    PARAMETERS:
    -----------
    option: atom
        :lower, :upper, :number, :lower_alpha, :upper_alpha, :combo_alpha,
        :password
    ------
    USAGE:
    ------
    Utils.random_string(:lower) -> "s"
    Utils.random_string(:upper) -> "E"
    Utils.random_string(:number) -> "6"
    Utils.random_string(:lower_alpha) -> "2", "c", ...
    Utils.random_string(:upper_alpha) -> "S", "8", ...
    Utils.random_string(:combo_alpha) -> "e", "6", "F", ...
    Utils.random_string(:password) -> "aOfw8tZpV2rdg4hlEmCysvLRUSNHB..."
    """

    def random_string(option) do

        alias Enum, as: E
        alias String, as: S

        numbers = "0123456789"
        lower = "abcdefghijklmnopqrstuvwxyz"
        upper = S.upcase(lower)

        cond do
            option === :lower ->
                S.split(lower, "", trim: true) |> E.random()
            option === :upper ->
                S.upcase(lower) |> S.split("", trim: true) |> E.random()
            option === :number ->
                S.split(numbers, "", trim: true) |> E.random()
            option === :lower_alpha ->
                lower <> numbers |> S.split("", trim: true) |> E.random()
            option === :upper_alpha ->
                upper <> numbers |> S.split("", trim: true) |> E.random()
            option === :combo_alpha ->
                lower <> upper <> numbers
                |> S.split("", trim: true) |> E.random()
            option === :password ->
                :crypto.strong_rand_bytes(100) |> Base.encode64(padding: false)
        end
    end

###############################################################################

    # ! NOT FULLY TESTED !
    def type(value) do
        @doc """
        Type-checker similar to Python's type().
        -----------
        PARAMETERS:
        -----------
        value: str | int | float | :atom | ...
            value to type-check; returns a string representing the type
        ------
        USAGE:
        ------
        # quickly check a type
        Utils.type(3.14) -> "float"
        # compare equality in a control structure
        Utils.type(:a) === "atom" -> true
        Utils.type(:a) !== "atom" -> false
        """
        cond do
            is_atom(value) -> "atom"
            is_binary(value) -> "binary"
            # is_bitstring(value) -> "string"
            is_boolean(value) -> "boolean"
            is_float(value) -> "float"
            is_function(value) -> "function"
            is_list(value) -> "list"
            is_number(value) -> "number"
            is_tuple(value) -> "tuple"
        end
    end

###############################################################################
# module
end
###############################################################################
