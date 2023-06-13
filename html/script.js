let obd = {}
let Categories = []

let currentAd = {}
let currentAdId = -1

$(document).ready(function(){
    $('.obd-container').hide();
    
    window.addEventListener('message', function(event){
        var eventData = event.data;
        if (eventData.action == "cwobd") {
            if (eventData.toggle) {
                obd.Open()
            } else {
                obd.Close()
            }
        }
        else if (eventData.action == "updateobd") {
            obd.Update(eventData)
        }
    });
});

function addScoreRows (scores) {
    // ACCELERATION
    let accRow = `
        <div id="$acc-row" class="score-list-row">
            <div class="left"> Acceleration </div>
            <div class="right"> ${scores.accel.toFixed(2)} </div>
        </div>
    `
    // SPEED
    let speedRow = `
        <div id="$speed-row" class="score-list-row">
            <div class="left"> Speed </div>
            <div class="right"> ${scores.speed.toFixed(2)} </div>
        </div>
    `
    // HANDLING
    let handlingRow = `
        <div id="$handling-row" class="score-list-row">
            <div class="left"> Handling </div>
            <div class="right"> ${scores.handling.toFixed(2)} </div>
        </div>
    `
    // BRAKING
    let brakingRow = `
        <div id="$braking-row" class="score-list-row">
            <div class="left"> Braking </div>
            <div class="right"> ${scores.braking.toFixed(2)} </div>
        </div>
    `
    // DRIVETRAIN
    let drivetrain = `AWD (${scores.drivetrain.toFixed(2)})`
    if (scores.drivetrain == 0) {
        drivetrain = 'RWD'
    } else if (scores.drivetrain == 1) {
        drivetrain = 'FWD'
    }
    let driveTrainRow = `
        <div id="drivetrain-row" class="score-list-row">
            <div class="left"> Drivetrain </div>
            <div class="right"> ${drivetrain} </div>
        </div>
    `

    $(".obd-items-left").html('');

    $(".obd-items-left").append(accRow);
    $(".obd-items-left").append(speedRow);
    $(".obd-items-left").append(handlingRow);
    $(".obd-items-left").append(brakingRow);
    $(".obd-items-left").append(driveTrainRow);  
}

function addDetailsRows (details) {
    const suspensionDamp = `
        <div id="$damp-row" class="score-list-row">
            <div class="left"> Suspension Damp </div>
            <div class="right"> ${((details.reboundDamp + details.compDamp)/2).toFixed(2)} </div>
        </div>
    `
    const suspensionForce = `
        <div id="$suspension-row" class="score-list-row">
            <div class="left"> Suspension Force </div>
            <div class="right"> ${details.suspensionForce.toFixed(2)} </div>
        </div>
    `
    const antiRoll = `
        <div id="$roll-row" class="score-list-row">
            <div class="left"> AntiRoll Force </div>
            <div class="right"> ${details.antiRoll.toFixed(2)} </div>
        </div>
    `
    const camberStiffness = `
        <div id="$camb-row" class="score-list-row">
            <div class="left"> Camber Stiffness </div>
            <div class="right"> ${details.camberStiffness.toFixed(2)} </div>
        </div>
    `
    const lowGrip = `
        <div id="$lowg-row" class="score-list-row">
            <div class="left"> Low end grip </div>
            <div class="right"> ${details.gripLow.toFixed(2)} </div>
        </div>
    `
    const highGrip = `
        <div id="$highg-row" class="score-list-row">
            <div class="left"> High end grip </div>
            <div class="right"> ${details.gripHigh.toFixed(2)} </div>
        </div>
    `

    const offroadGripLoss = `
        <div id="$offroad-row" class="score-list-row">
            <div class="left"> Off Road Grip Loss </div>
            <div class="right"> ${details.offroadGripLoss.toFixed(2)} </div>
        </div>
    `

    $(".obd-details-left").html('');
    $(".obd-details-right").html('');
    $(".obd-content-subheader").html('Details')

    $(".obd-details-left").append(suspensionForce);
    $(".obd-details-left").append(suspensionDamp);
    $(".obd-details-left").append(antiRoll);
    $(".obd-details-right").append(lowGrip);  
    $(".obd-details-right").append(highGrip);  
    $(".obd-details-right").append(offroadGripLoss);  
    $(".obd-details-right").append(camberStiffness);
}

function removeDetailsRows () {
    $(".obd-content-subheader").html('')
    $(".obd-details-left").html('');
    $(".obd-details-right").html('');
}

obd.Update = function(data) {
    const scores = data.score;
    const details = data.details
    const vehicleClass = data.class;
    const performanceScore = data.performanceScore;
    const vehicleModel = data.vehicleModel;
    const vehicleBrand = data.vehicleBrand;
    $(".obd-content-header").html(vehicleBrand + ' ' + vehicleModel);
    addScoreRows(scores)

    if (data.usingObd) {
        addDetailsRows(details)
    } else {
        removeDetailsRows()
    }

    const classScore = `<span>${vehicleClass}${performanceScore}</span>`
    $(".obd-items-right").html(classScore);

}

obd.Open = function() {
    $('.obd-container').fadeIn(250);
}

obd.Close = function() {
    $('.obd-container').fadeOut(250);
    $.post('https://cw-mechtool/exitObd');
}
