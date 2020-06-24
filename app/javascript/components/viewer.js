import Viewer from 'viewerjs';

import 'viewerjs/dist/viewer.css';

const viewerJS = () => {
  const viewer = new Viewer(document.getElementById('image'), {
    modal: true,
    viewed() {
      viewer.zoomTo(1);
    },
  });
}
// View an image

export { viewerJS }
