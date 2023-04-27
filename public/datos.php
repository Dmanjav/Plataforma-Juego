<?php
// Connect to the XAMPP database
$conn = mysqli_connect("localhost", "username", "password", "database_name");

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Prepare a query to retrieve the number of hours and date fields from the database
$sql = "SELECT hours, date FROM table_name";

// Execute the query and retrieve the results
$result = mysqli_query($conn, $sql);

// Format the results as a JSON object that is compatible with Chart.js
$chartData = array(
    "labels" => array(),
    "datasets" => array(
        array(
            "label" => "Number of Hours",
            "data" => array(),
            "backgroundColor" => "rgba(255, 99, 132, 0.2)",
            "borderColor" => "rgba(255, 99, 132, 1)",
            "borderWidth" => 1
        )
    )
);

while($row = mysqli_fetch_assoc($result)) {
    array_push($chartData["labels"], $row["date"]);
    array_push($chartData["datasets"][0]["data"], $row["hours"]);
}

// Close the database connection
mysqli_close($conn);

// Convert the chartData array to a JSON string
$chartDataJSON = json_encode($chartData);
?>

<!-- Create a canvas element for the chart -->
<canvas id="myChart"></canvas>

<!-- Include the Chart.js library -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Create the line chart using the chartData object -->
<script>
var ctx = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'line',
    data: <?php echo $chartDataJSON; ?>,
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});
</script>
