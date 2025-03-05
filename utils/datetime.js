



/**
 * Convert time string ('13:20:00') into 
 * common format '1:20pm' with meridiem.
 * @param {String} timeStr Time string to convert.
 * @return {String} Formatted time string.
 */
const timeStrToStd = (timeStr) => {
    const [hours, minutes] = timeStr.split(":").map(Number)
	return `${hours % 12}:${minutes == 0 ? '00' : minutes}` + (hours > 12 ? "pm" : "am")
}

/**
 * Convert time string ('13:20:00') into seconds (48000).
 * @param {String} timeStr Time string to convert.
 * @returns {Number} Numerical equivalent in seconds.
 */
const timeStrToSec = (timeStr) => {
    const [hours, minutes] = timeStr.split(":").map(Number)
    return (hours * 3600) + (minutes * 60);
}


module.exports = { timeStrToStd, timeStrToSec }