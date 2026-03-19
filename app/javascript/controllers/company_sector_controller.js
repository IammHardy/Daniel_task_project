import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["company", "sector"]

  connect() {
    this.loadSectors()
  }

  loadSectors() {
    const companyId = this.companyTarget.value

    if (!companyId) {
      this.clearSectors()
      return
    }

    fetch(`/admin/companies/${companyId}/sectors.json`)
      .then(response => response.json())
      .then(data => {
        this.sectorTarget.innerHTML = ""
        const defaultOption = document.createElement("option")
        defaultOption.text = "Select Sector"
        defaultOption.value = ""
        this.sectorTarget.add(defaultOption)

        data.forEach(sector => {
          const option = document.createElement("option")
          option.text = sector.name
          option.value = sector.id
          this.sectorTarget.add(option)
        })
      })
  }

  clearSectors() {
    this.sectorTarget.innerHTML = ""
    const defaultOption = document.createElement("option")
    defaultOption.text = "Select Sector"
    defaultOption.value = ""
    this.sectorTarget.add(defaultOption)
  }
}